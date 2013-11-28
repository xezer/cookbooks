#
# Author:: Seth Chisamore (<schisamo@opscode.com>)
# Cookbook Name:: java
# Attributes:: default
#
# Copyright 2010, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# remove the deprecated Ubuntu jdk packages
default['java']['remove_deprecated_packages'] = false

# default jdk attributes
default['java']['install_flavor'] = "oracle"
default['java']['jdk_version'] = '7'
default['java']['arch'] = kernel['machine'] =~ /x86_64/ ? "x86_64" : "i586"

case platform
when "centos","redhat","fedora","scientific","amazon"
  default['java']['java_home'] = "/usr/lib/jvm/java"
when "freebsd"
  default['java']['java_home'] = "/usr/local/openjdk#{java['jdk_version']}"
when "arch"
  default['java']['java_home'] = "/usr/lib/jvm/java-#{java['jdk_version']}-openjdk"
else
  default['java']['java_home'] = "/usr/lib/jvm/default-java"
end

# jdk6 attributes
# x86_64
default['java']['jdk']['6']['x86_64']['url'] = 'http://chef.htcblr.by/files/java/jdk-6u45-linux-x64.bin'
default['java']['jdk']['6']['x86_64']['checksum'] = '6b493aeab16c940cae9e3d07ad2a5c5684fb49cf06c5d44c400c7993db0d12e8'

# i586
default['java']['jdk']['6']['i586']['url'] = 'http://chef.htcblr.by/files/java/jdk-6u45-linux-i586.bin'
default['java']['jdk']['6']['i586']['checksum'] = 'd53b5a2518d80e1d95565f0adda54eee229dc5f4a1d1a3c2f7bf5045b168a357'

# jdk7 attributes
# x86_64
default['java']['jdk']['7']['x86_64']['url'] = 'http://chef.htcblr.by/files/java/jdk-7u40-linux-x64.tar.gz'
default['java']['jdk']['7']['x86_64']['checksum'] = '72f6e010592cad5e994276eee7db5f0b0d7c15c06949bd81f0e14811048bcf2c'

# i586
default['java']['jdk']['7']['i586']['url'] = 'http://chef.htcblr.by/files/java/jdk-7u40-linux-i586.tar.gz'
default['java']['jdk']['7']['i586']['checksum'] = '3a70b0c41cdf089d423c28336495c3e205f4fcb34f538dd82b80044eba670e8b'
