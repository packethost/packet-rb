require 'spec_helper'

RSpec.describe Packet::Project do
  let(:client) { double(Packet::Client) }
  before do
    allow(client).to receive(:create_project)
    allow(client).to receive(:update_project)
    allow(client).to receive(:delete_project)
  end
  subject { Packet::Project.new({}, client) }

  describe '.all' do
    let(:count) { rand(1..100) }
    subject { Packet::Project.all }

    it { expect(subject).to be_an(Array) }
    it { expect(subject).to all(be_a Packet::Project) }
    it { expect(subject.size).to be(count) }
  end

  describe '.find' do
    context 'when a project is found' do
      let(:id) { SecureRandom.uuid }
      subject { Packet::Project.find(id) }

      it { expect(subject).to be_a(Packet::Project) }
      it { expect(subject.id).to eq(id) }
    end

    context 'when no project is found' do
      subject { Packet::Project.find('invalid_project_id') }
      it { expect { subject }.to raise_error(Packet::NotFound) }
    end
  end

  describe '#save!' do
    context 'with a new record' do
      it 'calls Packet::Client#create_project' do
        expect(client).to receive(:create_project).once.with(subject)
        subject.save!
      end

      context 'when successful' do
        it { expect(subject.save!).to be(true) }
      end

      context 'when unsuccessful' do
        before { allow(client).to receive(:create_project).and_raise(Packet::Error) }

        it { expect { subject.save! }.to raise_error(Packet::Error) }
      end
    end

    context 'with an existing record' do
      before { subject.id = SecureRandom.uuid }

      it 'calls Packet::Client#update_project' do
        expect(client).to receive(:update_project).once.with(subject)
        subject.save!
      end

      context 'when successful' do
        it { expect(subject.save!).to be(true) }
      end

      context 'when unsuccessful' do
        before { allow(client).to receive(:update_project).and_raise(Packet::Error) }

        it { expect { subject.save! }.to raise_error(Packet::Error) }
      end
    end
  end

  describe '#destroy!' do
    before { subject.id = SecureRandom.uuid }

    it 'calls Packet::Client#delete_project' do
      expect(client).to receive(:delete_project).once.with(subject)
      subject.destroy!
    end

    context 'when successful' do
      it { expect(subject.destroy!).to be(true) }
    end

    context 'when unsuccessful' do
      before { allow(client).to receive(:delete_project).and_raise(Packet::Error) }

      it { expect { subject.destroy! }.to raise_error(Packet::Error) }
    end
  end

  it_behaves_like 'an entity'
end
