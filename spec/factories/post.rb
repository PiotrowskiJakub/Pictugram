FactoryGirl.define do
  factory :post do
    caption "nofilter"
    image { File.open('spec/files/images/mountains.jpg') }
    #image Rack::Test::UploadedFile.new(Rails.root + 'spec/files/images/mountains.jpg', 'img/jpg')
  end
end
