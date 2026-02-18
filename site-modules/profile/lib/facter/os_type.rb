Facter.add(:os_type) do
  confine :kernel => 'Linux'
  setcode do
    if Facter::Core::Execution.which('systemctl')
      service_status = Facter::Core::Execution.execute('systemctl status display-manager.service 2>/dev/null')
      
      if service_status && service_status.match?(/Active: active/)
        'workstation'
      else
        'server'
      end
    end
  end
end