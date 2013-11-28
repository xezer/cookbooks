#
# Cookbook Name:: cassandra
# Default:: default
#
# Copyright 2013, RADKEVICH
default[:cassandra][:installed]         = false
default[:cassandra][:cluster_name]      = 'Test Cluster'
default[:cassandra][:remote_url]        = 'http://107.20.108.96/files/cassandra/apache-cassandra-1.2.9-bin.tar'
default[:cassandra][:home_dir]          = '/opt/apache-cassandra'
default[:cassandra][:log_dir]           = '/var/log/cassandra'
default[:cassandra][:lib_dir]           = '/var/lib/cassandra'
default[:cassandra][:pid_dir]           = '/var/run/cassandra'
default[:cassandra][:pid]               = "#{node[:cassandra][:pid_dir]}/cassandra.pid"

default[:cassandra][:data_dirs]         = ["/var/lib/cassandra/data"]
default[:cassandra][:commitlog_dir]     = "/mnt/cassandra/commitlog"
default[:cassandra][:saved_caches_dir]  = "/var/lib/cassandra/saved_caches"

default[:cassandra][:initial_token]        = ''

default[:cassandra][:listen_address]      = "localhost"
default[:cassandra][:broadcast_address]   = nil
default[:cassandra][:seeds]             = ["127.0.0.1"]
default[:cassandra][:rpc_addr]          = "localhost"
default[:cassandra][:rpc_port]          = 9160
default[:cassandra][:storage_port]      = 7000
default[:cassandra][:mx4j_addr]         = "127.0.0.1"
default[:cassandra][:mx4j_port]         = "8081"

# User and group for tomcat
default[:cassandra][:user]              = 'cassandra'
default[:cassandra][:group]             = 'cassandra'
default[:cassandra][:uid]               = 932
default[:cassandra][:gid]               = 932

# MX4J Version
default[:cassandra][:mx4j_version]      = "3.0.2"
# MX4J location (at least as of Version 3.0.2)
default[:cassandra][:mx4j_release_url]  = "http://downloads.sourceforge.net/project/mx4j/MX4J%20Binary/#{node[:cassandra][:mx4j_version]}/mx4j-#{node[:cassandra][:mx4j_version]}.tar.gz?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fmx4j%2Ffiles%2F&ts=1303407638&use_mirror=iweb"

#
# Tunables -- Memory, Disk and Performance
#

default[:cassandra][:java_heap_size_min]           = "128M"        # consider setting equal to max_heap in production
default[:cassandra][:java_heap_size_max]           = "1650M"
default[:cassandra][:java_heap_size_eden]          = "1500M"
default[:cassandra][:disk_access_mode]             = "auto"
default[:cassandra][:concurrent_reads]             = 8             # 2 per core
default[:cassandra][:concurrent_writes]            = 32            # typical number of clients
default[:cassandra][:memtable_flush_writers]       = 1             # see comment in cassandra.yaml.erb
default[:cassandra][:memtable_flush_after]         = 60
default[:cassandra][:sliced_buffer_size]           = 64            # size of column slices
default[:cassandra][:thrift_framed_transport]      = 15            # default 15; fixes CASSANDRA-475, but make sure your client is happy (Set to nil for debugging)
default[:cassandra][:thrift_max_message_length]    = 16
default[:cassandra][:incremental_backups]          = false
default[:cassandra][:snapshot_before_compaction]   = false
default[:cassandra][:memtable_throughput]          = 64
default[:cassandra][:memtable_ops]                 = 0.3
default[:cassandra][:column_index_size]            = 64
default[:cassandra][:in_memory_compaction_limit]   = 64
default[:cassandra][:compaction_preheat_key_cache] = true
default[:cassandra][:commitlog_rotation_threshold] = 128
default[:cassandra][:commitlog_sync]               = "periodic"
default[:cassandra][:commitlog_sync_period]        = 10000
default[:cassandra][:flush_largest_memtables_at]   = 0.75
default[:cassandra][:reduce_cache_sizes_at]        = 0.85
default[:cassandra][:reduce_cache_capacity_to]     = 0.6
default[:cassandra][:rpc_timeout_in_ms]            = 50000
default[:cassandra][:rpc_keepalive]                = "true"
default[:cassandra][:phi_convict_threshold]        = 8
default[:cassandra][:request_scheduler]            = 'org.apache.cassandra.scheduler.NoScheduler'
default[:cassandra][:throttle_limit]               = 80           # 2x (concurrent_reads + concurrent_writes)
default[:cassandra][:request_scheduler_id]         = 'keyspace'
default[:cassandra][:endpoint_snitch]              = 'Ec2MultiRegionSnitch'
default[:cassandra][:dynamic_snitch_update_interval] = 1000
