require 'active_record/fixtures'

namespace :db do
  namespace :model do
    PATH = 'spec/fixtures'

    def dump(item, excluded = nil)
      object_id = "#{item.class.name.downcase}_#{item.id}:\n" # compose unique id
      dump = item.to_yaml(:UseHeader => true) # usage a standard yaml dump
      lines = dump.split("\n") # spit dump make a line array
      lines = lines[2..-1] # delete first two lines
      list = [] # lister for dumped fields
      if excluded # some fields can be excluded
        excluded_list = excluded.gsub('"', '').split # excluded can be a lister
        lines.each do |line|
          name = line.split(':')[0].strip # compose the name of the field for dumped string
          list << line unless excluded_list.include?(name) # copy the line to the final lister if name not in excluded
        end
      else
        list = lines
      end
      attr_index = list.index do |s|
        s.starts_with? 'attributes:'
      end
      list = list[0...attr_index] if attr_index # delete attributes part
      object_id + list.join("\n")
    end

    def simple_dump(item)
      s = "#{item.class.name.downcase}_#{item.id}:\n" # compose unique id
      item.attributes.each do |column, value|
        s += "  #{column}: #{value}\n"
      end
      s
    end

    desc 'Dump model into fixtures (argument:[model,"exclude1,exclude2,..."])'
    task :dump, [:model, :excluded] => :environment do |task, args|
      if args[:model]
        model_name = args[:model]
        # model_name = model_name.split('/').map{|c| c.capitalize}.join('::')
        model = model_name.classify.constantize
        model_file = "#{Rails.root}/#{PATH}/#{model_name.pluralize}.yml"
        File.delete(model_file) if File.exists?(model_file)
        File.open(model_file, 'w') do |file|
          items = model.all
          #item = items[0]
          #puts dump(item,args[:excluded])
          items.each do |item|
            # file.puts dump(item, args[:excluded])
            file.puts simple_dump(item)
            file.puts "\n"
          end
        end
        puts "Model #{model} dumped into #{PATH}/#{model_name.pluralize}.yml for #{Rails.env} environment."
      else
        puts "Usage: rake #{task}[model]"
      end
    end

    desc 'Dump model into fixtures (argument:[model]) [Old Version]'
    task :dump_old, [:model] => :environment do |task, args|
      if args[:model]
        model_name = args[:model]
        model = model_name.split("/").map { |c| c.capitalize }.join("::").constantize
        entries = model.find(:all, :order => 'id ASC')
        formatted, increment, tab = '', 1, '  '
        entries.each do |a|
          formatted += model_name + '_' + increment.to_s + ':' + "\n"
          increment += 1
          a.attributes.each do |column, value|
            formatted += tab
            value = value.to_s
            if value.match(/\n/) || value.match(/"/)
              formatted += column + ': |' + "\n"
              value.gsub!(/\r\n?/, "\n")
              value.split("\n").each do |v|
                formatted += tab + tab + v.strip + "\n"
              end
              formatted.chop!
            else
              formatted += column + ': '
              unless value.blank?
                if value.index(":") || value.index("_") || value.index("[") || value.index("]") || value.index("<") || value.index(">")
                  formatted += '"' + value + '"'
                else
                  formatted += value
                end
              end
            end
            formatted += "\n"
          end
          formatted += "\n"
        end
        model_file = "#{Rails.root}/#{PATH}/#{model_name.pluralize}.yml"
        File.delete(model_file) if File.exists?(model_file)
        File.open(model_file, 'w') { |f| f << formatted }
        puts "Model #{model} dumped into #{PATH}/#{model_name.pluralize}.yml for #{Rails.env} environment."
      else
        puts "Usage: rake #{task}[model]"
      end
    end


    def correct_attributes(model_name)
      model = model_name.split("/").map { |c| c.capitalize }.join("::").constantize
      model.columns_hash.each do |name, column|
        if (column.type == :time || column.type == :datetime) && name != 'updated_at' && name !='created_at'
          correct_time(model, name)
        end
      end
    end

    def correct_time(model, attribute)
      puts "Correct :#{attribute} of model #{model}"
      model.all.each do |o|
        time = o.send(attribute)
        if time
          correction = time.strftime('%z').to_i/100
          time -= correction.hours
          o.send("#{attribute}=", time)
          o.save!
        end
      end
    end

    desc 'Load from fixtures into model (argument:[model])'
    task :load, [:model] => :environment do |task, args|
      if args[:model]
        fixtures = args[:model].downcase.pluralize
        # system("echo *")
        system("rake db:fixtures:load FIXTURES=#{fixtures} FIXTURES_PATH=#{PATH}")
        # Rake::Task["db:fixtures:load"].invoke "FIXTURES=#{fixtures}"
        # Rake::Task["db:fixtures:load FIXTURES=#{fixtures}"].invoke
        # ActiveRecord::Base.establish_connection(ActiveRecord::Base.configurations[Rails.env])
        # ActiveRecord::Fixtures.create_fixtures("test/fixtures", fixtures)
        #correct_attributes(args[:model])
        puts "Fixture #{PATH}/#{fixtures}.yml loaded into model #{args[:model].capitalize} for #{Rails.env} environment."
      else
        puts "Usage: rake #{task}[model]"
      end
    end

    desc 'Migrate down model (argument:[model])'
    task :down, [:model] => :environment do |task, args|
      if args[:model]
        table = args[:model].gsub("/", "_").pluralize
        puts "Migrate down model #{args[:model]}"
        #Rake::Task['db:rolled:dump'].invoke args[:model]
        file = FileList.new(File.join(Rails.root, "db/migrate/*_create_#{table}.rb")).first
        raise "Can't find create migration for model #{args[:model]}" unless file
        version = /\d{14}/.match(file).to_s
        ENV['VERSION']= version
        puts "version: #{version}"
        Rake::Task['db:migrate:down'].invoke
      else
        puts "Usage: rake #{task}[model]"
      end
    end

    desc 'Migrate up model (argument:[model])'
    task :up, [:model] => :environment do |task, args|
      if args[:model]
        table = args[:model].gsub("/", "_").pluralize
        #Rake::Task['db:rolled:dump'].invoke args[:model]
        file = FileList.new(File.join(Rails.root, "db/migrate/*_create_#{table}.rb")).first
        raise "Can't find create migration for model #{args[:model]}" unless file
        version = /\d{14}/.match(file).to_s
        ENV['VERSION']= version
        Rake::Task['db:migrate:up'].invoke
      else
        puts "Usage: rake #{task}[model]"
      end
    end

    desc 'Migrate down and then up the model (argument:[model])'
    task :redo, [:model] => :environment do |task, args|
      if args[:model]
        Rake::Task['db:model:down'].invoke args[:model]
        Rake::Task['db:model:up'].invoke args[:model]
      else
        puts "Usage: rake #{task}[model]"
      end
    end

    desc 'Reset the model: dump, migrate down, then up and load (argument:[model])'
    task :reset, [:model] => :environment do |task, args|
      if args[:model]
        Rake::Task['db:model:dump'].invoke args[:model]
        Rake::Task['db:model:redo'].invoke args[:model]
        Rake::Task['db:model:load'].invoke args[:model]
      else
        puts "Usage: rake #{task}[model]"
      end
    end

  end
end
