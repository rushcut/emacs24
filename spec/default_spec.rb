# -*- coding: utf-8 -*-

require_relative 'spec_helper'

describe 'emacs24::default' do

  def chef_run(platforms={})
    ChefSpec::Runner.new(platforms).converge(described_recipe)
  end

  it { expect(chef_run(platform: "debian", version: "7.2")).to include_recipe('emacs24::source') }
  it { expect(chef_run(platform: "ubuntu", version: "12.04")).to include_recipe('emacs24::source') }
  it { expect(chef_run(platform: "centos", version: "6.5")).to include_recipe('emacs24::source') }
  it { expect(chef_run(platform: "centos", version: "7.0")).to include_recipe('emacs24::package') }

end
