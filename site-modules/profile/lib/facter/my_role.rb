
# modules/site_facts/lib/facter/role.rb

Facter.add(:my_role) do
  setcode do
    'hello'
  end
end