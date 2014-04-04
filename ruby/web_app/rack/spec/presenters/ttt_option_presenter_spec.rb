require 'presenters/ttt_option_presenter'

describe TTTOptionPresenter do
  describe '#generate_options' do
    it 'generates the ttt options' do
      options = {"player one"  => ['human', 'computer'],
                 "player two"  => ['human', 'computer'],
                 "board option"=> ['3x3'  , '4x4'     ]}
      result = described_class.generate_options(options)
      result.should include('form')
      result.should include('player one')
      result.should include('player two')
      result.should include('board option')
    end
  end
end
