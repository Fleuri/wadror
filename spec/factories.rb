FactoryGirl.define do
  factory :user do
    username "Pekka"
    password "foobar1"
    password_confirmation "foobar1"
  end

  factory :rating, :class => Rating do
    score 10
  end

  factory :rating2, :class => Rating do
    score 20
  end

  factory :rating3, :class => Rating do
    score 30
  end

  factory :brewery do
    name "anonymous"
    year 1900
  end

  factory :brewery2, :class => Brewery do
    name "trollface"
    year 2000
  end

  factory :beer do
    name "anonymous"
    brewery
    style "Lager"
  end

  factory :beer2, :class => Beer do
    name "Cola"
    brewery
    style "Limu"
  end


end
