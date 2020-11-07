require 'rails_helper'
require 'carrierwave/test/matchers'

describe UserPhotoUploader do
  include CarrierWave::Test::Matchers

  let(:user) { create(:user) }
  let(:uploader) { UserPhotoUploader.new(user, :photo) }
  let(:path_to_photo) { "#{Rails.root}/spec/fixtures/arrow.jpg" }


  before do
    UserPhotoUploader.enable_processing = true
    File.open(path_to_photo) { |f| uploader.store!(f) }
  end

  after do
    UserPhotoUploader.enable_processing = false
    uploader.remove!
  end

  describe '.store_dir' do
    context 'when env is test' do
      it 'return path' do
        expect(uploader.store_dir).to eq("#{Rails.root}/spec/fixtures/uploads/user/photo/#{user.id}")
      end
    end

    context 'when env is pro' do
      before { allow(Rails).to receive(:env).and_return(ActiveSupport::StringInquirer.new("development")) }

      it 'return path' do
        expect(uploader.store_dir).to eq("uploads/user/photo/#{user.id}")
      end
    end
  end

  it "has the correct format" do
    expect(uploader).to be_format('JPEG')
  end
end