require 'test_helper'

class DictionaryTest < ActiveSupport::TestCase

	test "set key" do
		w = Dictionary.set "test"
		puts w
		assert w.id
		assert w.get == "test"
	end

	test "set languages" do
		w = Dictionary.set "test"
		w.set "en: test"
		w.set "ru: тест"
		puts w
		assert w.get == "test\nen: test\nru: тест"
	end

	test "set multi words" do
		w = Dictionary.set "test"
		w.set "en: test"
		w.set "ru: тест"
		w.set "ru: проверка"
		puts w
		assert w.get == "test\nen: test\nru: тест / проверка"
	end

	test "set multi words with existed key" do
		w1 = Dictionary.set "test"
		w1.set "en: test"
		w1.set "ru: тест"
		puts w1
		w2 = Dictionary.set "test"
		assert w1.id = w2.id
		w2.set "ru: проверка"
		puts w2
		assert w2.get == "test\nen: test\nru: тест / проверка"
	end

	test "translate" do
		w = Dictionary.set "t"
		w.set "en: test / check"
		w.set "ru: тест / проверка / чек"
		assert Dictionary.en('test') == 'test'
		assert Dictionary.ru('test') == 'тест'
		assert Dictionary.en('тест') == 'test'

		assert Dictionary.ru('check') == 'тест'
		assert Dictionary.ru_syn('check') == 'проверка'
		assert Dictionary.ru_syns('check').size == 3

		assert Dictionary.en('проверка') == 'test'
		assert Dictionary.en_syn('проверка') == 'check'
		assert Dictionary.en_syns('чек').size == 2
	end

end
