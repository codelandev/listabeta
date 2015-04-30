class Status < EnumerateIt::Base
  associate_values(
    :pendent => 1,
    :approved => 2,
    :unapproved => 3
  )
end
