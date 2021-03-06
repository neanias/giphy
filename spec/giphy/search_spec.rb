require 'spec_helper'

describe Giphy::Search do
  class TestObject ; include Giphy::Search ; end

  subject { TestObject.new }

  let(:client)        { double('client') }
  let(:client_result) { double('result') }
  let(:response)      { double('response') }
  let(:options)       { {option: 'option'} }

  before { Giphy::Client.stub(new: client) }

  describe "#recent" do
    it "returns a batch of Gifs from the client result" do
      client.stub(:recent).with(options).and_return(client_result)
      Giphy::Gif.stub(:build_batch_from).with(client_result).and_return(response)
      expect(subject.recent(options)).to eq response
    end
  end

  describe "#translate" do
    it "returns a batch of Gifs from the client result" do
      client.stub(:translate).with('word').and_return(client_result)
      Giphy::Gif.stub(:build_batch_from).with(client_result).and_return(response)
      expect(subject.translate('word')).to eq response
    end
  end

  describe "#search" do
    it "returns a batch of Gifs from the client result" do
      client.stub(:search).with('keyword', options).and_return(client_result)
      Giphy::Gif.stub(:build_batch_from).with(client_result).and_return(response)
      expect(subject.search('keyword', options)).to eq response
    end
  end

  describe "#flag" do
    it "returns a new FlaggedGif from the client result" do
      client.stub(:flag).with('wdsf34df').and_return(client_result)
      Giphy::FlaggedGif.stub(:new).with(client_result).and_return(response)
      expect(subject.flag('wdsf34df')).to eq response
    end
  end

  describe "#flagged" do
    it "returns a batch of FlaggedGifs from the client result" do
      client.stub(flagged: client_result)
      Giphy::FlaggedGif.stub(:build_batch_from).with(client_result).and_return(response)
      expect(subject.flagged).to eq response
    end
  end

  describe "#favorite" do
    it "returns a new FavoriteGifs from the client result" do
      client.stub(:favorite).with('wdsf34df').and_return(client_result)
      Giphy::FavoriteGif.stub(:new).with(client_result).and_return(response)
      expect(subject.favorite('wdsf34df')).to eq response
    end
  end

  describe "#favorites" do
    it "returns a batch of FavoriteGifs from the client result" do
      username = 'absurdnoise'
      client.stub(:favorites).with(username, options).and_return(client_result)
      Giphy::FavoriteGif.stub(:build_batch_from).with(client_result).and_return(response)
      expect(subject.favorites(username, options)).to eq response
    end
  end

  describe "#screensaver" do
    it "returns a new Gif from the client result" do
      client.stub(:screensaver).with('tag').and_return(client_result)
      Giphy::Gif.stub(:new).with(client_result).and_return(response)
      expect(subject.screensaver('tag')).to eq response
    end
  end

  describe "#random" do
    it "returns a new Gif from the client result" do
      client.stub(random: client_result)
      Giphy::RandomGif.stub(:new).with(client_result).and_return(response)
      expect(subject.random).to eq response
    end
  end

  describe "#artists" do
    it "returns a batch of Artists from the client result" do
      client.stub(artists: client_result)
      Giphy::Artist.stub(:build_batch_from).with(client_result).and_return(response)
      expect(subject.artists).to eq response
    end
  end

  describe "#gif_by_artist" do
    it "returns a batch of Gifs from the client result" do
      client.stub(:artists).with(username: 'artist_name', option: 'option').and_return(client_result)
      Giphy::Gif.stub(:build_batch_from).with(client_result).and_return(response)
      expect(subject.gif_by_artist('artist_name', options)).to eq response
    end
  end

  describe "#gif_by_id" do
    it "returns a batch of Gifs from the client result" do
      gif_by_id = double
      Giphy::GifByID.stub(new: gif_by_id)
      gif_by_id.stub(:get).with(['wdsf34df', 'ydfe779f']).and_return(response)
      expect(subject.gif_by_id('wdsf34df', 'ydfe779f')).to eq response
    end
  end
end
