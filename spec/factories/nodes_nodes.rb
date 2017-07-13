FactoryGirl.define do
  factory :nodes_node, class: 'Nodes::Node' do
    sequence(:name) {Faker::Name.first_name}
  end
end
