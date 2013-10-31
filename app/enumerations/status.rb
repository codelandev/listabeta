class Status < EnumerateIt::Base
  associate_values(
    :in_development => 1,
    :private_beta => 2,
    :public_beta => 3,
    :online => 4
  )
end
