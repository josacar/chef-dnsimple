require_relative 'spec_helper'

describe 'dnsimple::default' do
  cached(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  it 'installs libxml2-dev and libxslt1-dev packages' do
    expect(chef_run).to install_package 'libxml2-dev'
    expect(chef_run).to install_package 'libxslt1-dev'
  end

  it 'installs fog chef_gem' do
    expect(chef_run).to install_chef_gem 'fog'
  end
end