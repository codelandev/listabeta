class A5 < EnumerateIt::Base
  associate_values(
    :range1 => 1,
    :range2 => 2,
    :range3 => 3,
    :range4 => 4,
    :range5 => 5,
    :range6 => 5,
    :range7 => 7
  )

  sort_by :value
end
