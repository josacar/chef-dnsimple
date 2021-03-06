require 'spec_helper'
require 'fog/dnsimple'

describe 'dnsimple_test::existing_record_different_type' do
  include_context 'dnsimple'

  context 'with an existing record with the same name and ttl different type' do
    it 'does not delete existing record and creates new record' do
      create_record_to_do_not_delete
      chef_run
      expected_records = {
        'NS' => '1.2.3.4',
        'A' => '1.1.1.1'
      }

      records = dnsimple_zone.records.select { |r| r.name == '' }
      expect(records.size).to eq 2

      records.each do |record|
        expect(record.value).to eq expected_records[record.type]
        expected_records.delete(record.type)
      end
      expect(expected_records).to be_empty
    end
  end
end