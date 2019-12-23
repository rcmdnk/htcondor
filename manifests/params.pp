# htcondor::params
class htcondor::params {
  $schedulers                     = lookup('schedulers', {merge => unique, default_value => []})
  $managers                       = lookup('managers', {merge => unique, default_value => []})
  $workers                        = lookup('workers', {merge => unique, default_value => []})

  $collector_port                 = lookup('collector_port', {default_value => ''})


  $service                        = lookup('service', {default_value => true})
  $config                         = lookup('config', {default_value => true})

  $is_manager                     = lookup('is_manager', {default_value => false})
  $is_scheduler                   = lookup('is_scheduler', {default_value => false})
  $is_worker                      = lookup('is_worker', {default_value => false})

  $cluster_has_multiple_domains   = lookup('cluster_has_multiple_domains', {default_value => false})
  $persistent_config              = lookup('persistent_config', {default_value => false})
  $settable_attrs_administrator   = lookup('settable_attrs_administrator', {default_value => ''})
  $collector_name                 = lookup('collector_name', {default_value => 'Personal Condor at $(FULL_HOSTNAME)'})
  $repo_priority                  = lookup('repo_priority', {default_value => '99'})
  $condor_version                 = lookup('condor_version', {default_value => 'present'})
  $custom_machine_attributes      = lookup('custom_machine_attribute', {merge => hash, default_value => {}})
  $custom_job_attributes          = lookup('custom_job_attributes', {merge => hash, default_value => {}})

  $use_debug_notify               = lookup('use_debug_notify', {default_value => true})

  # this is one of the funding requirements for HTCondor
  # for more information see https://research.cs.wisc.edu/htcondor/privacy.html
  $enable_condor_reporting        = lookup('enable_condor_reporting', {default_value => true})
  $enable_cgroup                  = lookup('enable_cgroup', {default_value => false})
  $proportional_swap_assignment   = lookup('proportional_swap_assignment', {default_value => false})
  $enable_multicore               = lookup('enable_multicore', {default_value => false})
  $enable_healthcheck             = lookup('enable_healthcheck', {default_value => false})


  if $facts['os']['family'] == 'RedHat' and $facts['os']['release']['major'] == '7' {
    $htcondor_cgroup_default = '/system.slice/condor.service'
  }
  else{
    $htcondor_cgroup_default = 'htcondor'
  }
  $htcondor_cgroup                = lookup('htcondor_cgroup', {default_value => $htcondor_cgroup_default})


  $high_priority_groups           = lookup('high_priority_groups', {merge => hash, default_value => undef})
  $multicore_priority             = lookup('multicore_priority', {default_value => -2})

  $default_accounting_groups      = {
    'CMS'            => {
      priority_factor => 10000.00,
      dynamic_quota   => 0.80,
    }
    ,
    'CMS.production' => {
      priority_factor => 10000.00,
      dynamic_quota   => 0.95,
    }
  }
  $accounting_groups              = lookup('accounting_groups', {merge => hash, default_value => $default_accounting_groups})

  $priority_halflife              = lookup('priority_halflife', {default_value => 43200})
  $default_prio_factor            = lookup('default_prio_factor', {default_value => 100000.00})
  $group_accept_surplus           = lookup('group_accept_surplus', {default_value => true})
  $group_autoregroup              = lookup('group_autoregroup', {default_value => true})

  $health_check_script            = lookup('health_check_script', {default_value => "puppet:///modules/${module_name}/healhcheck_wn_condor"})
  $include_username_in_accounting = lookup('include_username_in_accounting', {default_value => false})
  $primary_accounts               = lookup('primary_accounts', {merge => unique, default_value => []})
  $install_repositories           = lookup('install_repositories', {default_value => true})
  $gpgcheck                       = lookup('gpgcheck', {default_value => true})
  $gpgkey                         = lookup('gpgkey', {default_value => 'http://htcondor.org/yum/RPM-GPG-KEY-HTCondor'})
  $dev_repositories               = lookup('dev_repositories', {default_value => false})
  $prev_repositories              = lookup('prev_repositories', {default_value => false})
  $stable_version                 = lookup('stable_version', {default_value => '8.8'})

  $machine_owner                  = lookup('machine_owner', {default_value => 'physics'})

  $number_of_cpus                 = lookup('number_of_cpus', {default_value => $::processors['count' ]})
  $start                          = lookup('start', {default_value => ''})

  $partitionable_slots            = lookup('partitionable_slots', {default_value => true})
  $slots                          = lookup('slots', {default_value => {}})
  $memory                         = lookup('memory', {default_value => ""})
  $job_renice_increment           = lookup('job_renice_increment', {default_value => 10})
  $memory_overcommit              = lookup('memory_overcommit', {default_value => 1.5})
  $request_memory                 = lookup('request_memory', {default_value => true})

  $starter_job_environment        = lookup('starter_job_environment', {merge => hash, default_value => {}})
  $manage_selinux                 = lookup('manage_selinux', {default_value => true})
  $pool_home                      = lookup('pool_home', {default_value => '/pool'})
  $pool_create                    = lookup('pool_create', {default_value => true})
  $mount_under_scratch_dirs       = lookup('mount_under_scratch_dirs', {merge => unique, default_value => ['/tmp', '/var/tmp']})
  $queues                         = lookup('grid_queues', {default_value => undef})
  $periodic_expr_interval         = lookup('periodic_expr_interval', {default_value => 60})
  $max_periodic_expr_interval     = lookup('max_periodic_expr_interval', {default_value => 1200})
  $remove_held_jobs_after         = lookup('remove_held_jobs_after', {default_value => 1200})
  $leave_job_in_queue             = lookup('leave_job_in_queue', {default_value => false})
  $use_x509userproxy              = lookup('use_x509userproxy', {default_value => false})
  $max_walltime                   = lookup('max_walltime', {default_value => '80 * 60 * 60'})
  $max_cputime                    = lookup('max_cputime', {default_value => '80 * 60 * 60'})
  $memory_factor                  = lookup('memory_factor', {default_value => '1000'})
  $additional_periodic_remove     = lookup('additional_periodic_remove', {default_value => ''})

  $ganglia_cluster_name           = lookup('ganglia_cluster_name', {default_value => undef})

  $uid_domain                     = lookup('uid_domain', {default_value => 'example.org'})
  $default_domain_name            = lookup('default_domain_name', {default_value => $uid_domain})
  $filesystem_domain              = lookup('filesystem_domain', {default_value => $::fqdn})

  $use_accounting_groups          = lookup('use_accounting_groups', {default_value => false})
  $use_htcondor_account_mapping   = lookup('use_htcondor_account_mapping', {default_value => true})

  # service security
  $condor_user                    = lookup('condor_user', {default_value => root})
  $condor_group                   = lookup('condor_group', {default_value => root})
  $condor_uid                     = lookup('condor_uid', {default_value => 0})
  $condor_gid                     = lookup('condor_gid', {default_value => 0})

  # authentication
  $use_anonymous_auth             = lookup('use_anonymous_auth', {default_value => false})
  $use_fs_auth                    = lookup('use_fs_auth', {default_value => true})
  $use_password_auth              = lookup('use_password_auth', {default_value => true})
  $use_kerberos_auth              = lookup('use_kerberos_auth', {default_value => false})
  $use_claim_to_be_auth           = lookup('use_claim_to_be_auth', {default_value => false})
  $use_ssl_auth                   = lookup('use_ssl_auth', {default_value => false})
  $use_cert_map_file              = lookup('use_cert_map_file', {default_value => false})
  $use_krb_map_file               = lookup('use_krb_map_file', {default_value => false})
  $use_pid_namespaces             = lookup('use_pid_namespaces', {default_value => false})
  $cert_map_file                  = lookup('cert_map_file', {default_value => '/etc/condor/certificate_mapfile'})
  $cert_map_file_source           = lookup('cert_map_file_source', {default_value => "puppet:///modules/${module_name}/certificate_mapfile"})
  $krb_map_file                   = lookup('krb_map_file', {default_value => '/etc/condor/kerberos_mapfile'})
  $krb_map_file_template          = lookup('krb_map_file_template', {default_value => "${module_name}/mapfile.kmap.erb"})
  $machine_list_prefix            = lookup('machine_list_prefix', {default_value => 'condor_pool@$(UID_DOMAIN)/'})
  $pool_password_file             = lookup('pool_password_file', {default_value => "puppet:///modules/${module_name}/pool_password"})
  $ssl_server_keyfile             = lookup('ssl_server_keyfile', {default_value => ''})
  $ssl_client_keyfile             = lookup('ssl_client_keyfile', {default_value => ''})
  $ssl_server_certfile            = lookup('ssl_server_certfile', {default_value => ''})
  $ssl_client_certfile            = lookup('ssl_client_certfile', {default_value => ''})
  $ssl_server_cafile              = lookup('ssl_server_cafile', {default_value => ''})
  $ssl_client_cafile              = lookup('ssl_client_cafile', {default_value => ''})
  $ssl_server_cadir               = lookup('ssl_server_cadir', {default_value => ''})
  $ssl_client_cadir               = lookup('ssl_client_cadir', {default_value => ''})

  # for private networks
  $uses_connection_broker         = lookup('uses_connection_broker', {default_value => false})
  $private_network_name           = lookup('private_network_name', {default_value => ''})

  # SharedPort service configuration
  $use_shared_port                = lookup('use_shared_port', {default_value => false})
  $shared_port                    = lookup('shared_port', {default_value => 9618})
  $shared_port_collector_name     = lookup('shared_port_collector_name', {default_value => 'collector'})

  # Custom logging config
  $use_custom_logs                = lookup('use_custom_logs', {default_value => false})
  $log_to_syslog                  = lookup('log_to_syslog', {default_value => false})
  $logging_parameters             = lookup('logging_parameters', {default_value => {}})

  # Singularity configuration
  $use_singularity                = lookup('use_singularity', {default_value => false})
  $singularity_path               = lookup('singularity_path', {default_value => '/usr/bin/singularity'})
  $force_singularity_jobs         = lookup('force_singularity_jobs', {default_value => false})
  $singularity_image_expr         = lookup('singularity_image', {default_value => 'SingularityImage'})
  $singularity_bind_paths         = lookup('singularity_bind_paths', {merge => unique, default_value => 'SingularityBind'})
  $singularity_target_dir         = lookup('singularity_target_dir', {default_value => ''})

  # Defrag settings
  $defrag_interval                = lookup('defrag_interval', {default_value => 600})
  $defrag_draining_machines_per_hour = lookup('defrag_draining_machines_per_hour', {default_value => 60})
  $defrag_max_concurrent_draining = lookup('defrag_max_concurrent_draining', {default_value => 8})
  $defrag_max_whole_machines      = lookup('defrag_max_whole_machines', {default_value => 20})
  $defrag_schedule                = lookup('defrag_schedule', {default_value => "graceful"})
  $defrag_fixed_multicore         = lookup('defrag_fixed_multicore', {default_value => 0})

  # notification settings
  $admin_email                    = lookup('admin_email', {default_value => 'localhost'})
  $email_domain                   = lookup('email_domain', {default_value => 'localhost'})
  # template paths
  $template_config_local          = lookup('template_config_local', {default_value => "${module_name}/condor_config.local.erb"})
  $template_security              = lookup('template_security', {default_value => "${module_name}/10_security.config.erb"})
  $template_resourcelimits        = lookup('template_resourcelimits', {default_value => "${module_name}/12_resourcelimits.config.erb"})
  $template_queues                = lookup('template_queues', {default_value => "${module_name}/13_queues.config.erb"})
  $template_schedd                = lookup('template_schedd', {default_value => "${module_name}/21_schedd.config.erb"})
  $template_fairshares            = lookup('template_fairshares', {default_value => "${module_name}/11_fairshares.config.erb"})
  $template_manager               = lookup('template_collector', {default_value => "${module_name}/22_manager.config.erb"})
  $template_ganglia               = lookup('template_ganglia', {default_value => "${module_name}/23_ganglia.config.erb"})
  $template_workernode            = lookup('template_workernode', {default_value => "${module_name}/20_workernode.config.erb"})
  $template_defrag                = lookup('template_defrag', {default_value => "${module_name}/33_defrag.config.erb"})
  $template_highavailability      = lookup('template_defrag', {default_value => "${module_name}/30_highavailability.config.erb"})
  $template_sharedport            = lookup('template_sharedport', {default_value => "${module_name}/27_shared_port.config.erb"})
  $template_logging               = lookup('template_logging', {default_value => "${module_name}/14_logging.config.erb"})
  $template_singularity           = lookup('template_singularity', {default_value => "${module_name}/50_singularity.config.erb"})
}
