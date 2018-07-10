#!/opt/puppetlabs/puppet/bin/ruby
require 'open3'
require 'puppet'

begin
  Puppet.initialize_settings
  @configfile = Puppet.settings['config']
  x = ::Puppet::Resource.new('ini_setting', 'noop', parameters: { ensure: 'present', path: @configfile, section: 'agent', setting: 'noop', value: 'true' })
  _result, _report = ::Puppet::Resource.indirection.save(x)
  Puppet.reparse_config_files
  puts "Noop is now #{Puppet.settings['noop']}"
rescue => e
  raise "Could not manage noop: #{e}"
end
