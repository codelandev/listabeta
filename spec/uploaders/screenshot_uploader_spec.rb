require 'spec_helper'
require 'carrierwave/test/matchers'

describe ScreenshotUploader do
  include CarrierWave::Test::Matchers

  before do
    ScreenshotUploader.enable_processing = true
    @startup = Startup.make!
    @uploader = ScreenshotUploader.new(@startup, :screenshot)
    @uploader.store!(File.open(Rails.root.join('spec', 'fixtures', 'photo.png')))
  end

  after do
    ScreenshotUploader.enable_processing = false
    @uploader.remove!
  end

  describe 'default_url' do
    it 'returns default image in assets path' do
      user = Startup.new
      expect(user.screenshot_url) == ActionController::Base.helpers.asset_path("startup_default.png")
    end
  end

  # describe 'big_thumb version' do
  #   it 'should have a size of 290x199' do
  #     expect(@uploader.big_thumb).to have_dimensions(290, 199)
  #   end
  # end

  # describe 'thumb version' do
  #   it 'should have a size of 120x120' do
  #     expect(@uploader.thumb).to have_dimensions(120, 120)
  #   end
  # end
end
