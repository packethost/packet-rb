shared_examples 'an entity' do
  describe '#id' do
    it { expect(subject).to respond_to(:id) }
  end

  [:created_at, :updated_at].each do |timestamp|
    describe timestamp do
      it { expect(subject).to respond_to(timestamp) }
      it { expect(subject.send(timestamp)).to be_a(Time) }
    end
  end
end
