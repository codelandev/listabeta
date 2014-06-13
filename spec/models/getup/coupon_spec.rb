require 'spec_helper'

describe Getup::Coupon do
  def stub_getup_request(filename, method = :all, path = '', body = nil, query = {}, status = 200)
    stub_request(method, "https://broker.getupcloud.com#{path}").
      with(body: body,
           query: query,
           headers: {
             Authorization: "Bearer #{ENV['GETUP_SECRET_KEY_CODED']}"
           }).
      to_return(status: status,
                body: filename ? Rails.root.join('spec', 'fixtures', filename) : nil,
                headers: {
                  content_type: 'application/json'
                })
  end

  describe '.create' do
    context 'with default params' do
      before do
        stub_getup_request('getup_success_create.json',
                           :post,
                           '/getup/partner/coupon/',
                           { profile: '1gear' },
                           {},
                           201)
      end

      subject { described_class.create }

      context 'JSON response' do
        it { expect(subject).to have_key('data') }

        it { expect(subject).to have_key('success') }

        it { expect(subject).to have_key('message') }

        it { expect(subject).to have_key('status') }
      end
    end

    context 'with another profile and default options' do
      before do
        stub_getup_request('getup_success_create.json',
                           :post,
                           '/getup/partner/coupon/',
                           { profile: 'standard' },
                           {},
                           201)
      end

      subject { described_class.create('standard') }

      context 'JSON response' do
        it { expect(subject).to have_key('data') }

        it { expect(subject).to have_key('success') }

        it { expect(subject).to have_key('message') }

        it { expect(subject).to have_key('status') }
      end
    end

    context 'with another profile and options' do
      before do
        stub_getup_request('getup_success_create.json',
                           :post,
                           '/getup/partner/coupon/',
                           { profile: 'standard' },
                           { another_param: false },
                           201)
      end

      subject { described_class.create('standard', another_param: false) }

      context 'JSON response' do
        it { expect(subject).to have_key('data') }

        it { expect(subject).to have_key('success') }

        it { expect(subject).to have_key('message') }

        it { expect(subject).to have_key('status') }
      end
    end
  end

  describe '.list' do
    context 'with default params' do
      before do
        stub_getup_request('getup_success_list.json', :get, '/getup/partner/coupon/', {}, {}, 200)
      end

      subject { described_class.list }

      context 'JSON response' do
        it { expect(subject).to have_key('data') }

        it { expect(subject).to have_key('success') }

        it { expect(subject).to have_key('message') }

        it { expect(subject).to have_key('status') }
      end
    end
  end

  describe '.destroy' do
    before do
      stub_getup_request(nil,
                         :delete,
                         "/getup/partner/coupon/my-awesome-coupon/",
                         {},
                         {},
                         200)
    end

    subject { described_class.destroy('my-awesome-coupon') }

    it { expect(subject).to be_nil }

    it { expect(subject).to be_success }
  end

  describe '.get_info' do
    context 'with default params' do
      before do
        stub_getup_request('getup_success_get_info.json', :get, '/getup/partner/', {}, {}, 200)
      end

      subject { described_class.get_info }

      context 'JSON response' do
        it { expect(subject).to have_key('data') }

        it { expect(subject).to have_key('success') }

        it { expect(subject).to have_key('message') }

        it { expect(subject).to have_key('status') }
      end
    end
  end

  describe '.new_coupon' do
    context 'success request' do
      before do
        stub_getup_request('getup_success_create.json',
                           :post,
                           '/getup/partner/coupon/',
                           { profile: '1gear' },
                           {},
                           201)
      end

      subject { described_class.new_coupon }

      it { expect(subject).to eq('my-awesome-coupon') }
    end

    context 'request fail' do
      before do
        stub_getup_request('getup_failure_create.json',
                           :post,
                           '/getup/partner/coupon/',
                           { profile: '1gear' },
                           {},
                           404)
      end

      subject { described_class.new_coupon }

      it { expect(subject).to be_nil }
    end
  end
end
