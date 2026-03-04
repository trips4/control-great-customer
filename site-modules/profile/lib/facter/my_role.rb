Facter.add(:my_role) do
  setcode do
    trusted = Facter.value(:trusted)
    certname = trusted.is_a?(Hash) ? trusted['certname'] : nil

    if certname && certname.include?('almagt')
      'my_win'
    else
      'hello_goodbye'
    end
  end
end