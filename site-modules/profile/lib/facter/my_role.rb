
# modules/site_facts/lib/facter/role.rb

Facter.add(:my_role) do
  setcode do
    # Get the certname Puppet uses for this node
    certname = Facter.value(:clientcert)

    # Defensive: handle nil
    next nil if certname.nil? || certname.empty?

    # Normalize to lowercase for case-insensitive match
    cert = certname.downcase

    if cert.include?('ora') || cert.include?('oradv')
      'db_server'
    else
      # You can choose something else here, like 'agent_only' or nil
      'cmon'
    end
  end
end