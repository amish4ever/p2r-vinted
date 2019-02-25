#
# Cookbook:: p2r-vinted
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

include_recipe 'p2r-vinted::install'
include_recipe 'p2r-vinted::configs'
include_recipe 'p2r-vinted::scripts'
