FactoryGirl.define do
  factory :cohort do
    name { "Otters 2014" }
    slug { "otters-2014" }
    location { "Chicago" }

    factory :chicago_cohort do
    end

    factory :san_francisco_cohort do
      name { "Gopher Snakes 2014" }
      slug { "gopher-snakes-2014" }
      location { "San Francisco" }
    end

    factory :new_york_cohort do
      name { "Eastern Moose 2014" }
      slug { "eastern-moose-2014" }
      location { "New York" }
    end
  end
end
