FactoryGirl.define do
  factory :post do
    caption "nofilter"
    image { File.open('spec/files/images/mountains.jpg') }
  end
end
