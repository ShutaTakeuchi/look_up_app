class TweetsController < ApplicationController
  def search
    client = Twitter::REST::Client.new do |config|
      # 事前準備で取得したキーのセット
      config.consumer_key = "IvpGGvlBGK9RnKCIrnji21hwb"
      config.consumer_secret = "9jYwXMLGssUYqxrHjjXvAm3xydGGjIVqAZC9M2qSXOF0sHMsks"
    end
    @tweets = []
    since_id = nil

    # 検索ワードが存在していたらツイートを取得
    if params[:keyword].present?
      # リツイートを除く、検索ワードにひっかかった最新10件のツイートを取得する
      tweets = client.search(params[:keyword], count: 300, result_type: "recent", exclude: "retweets", since_id: since_id, lang: "en")

      # 取得したツイートをモデルに渡す
      tweets.take(300).each do |tw|
        tweet = Tweet.new(tw.full_text)
        @tweets << tweet
      end

      # 条件追加
      contents = Array.new
      @tweets.each do |tweet|
        if tweet.contents.include?("@") == false && tweet.contents.include?("http") == false
          contents.unshift(tweet.contents)
        end
      end

      @contents = contents

      if @contents.size == 0
        @error = "Could not find it"
      end

      # 検索ワード表示のため
      @keyword = params[:keyword]
    end

    # respond_to do |format|
    #   format.html # show.html.erb
    #   format.json { render json: @tweets } # jsonを指定した場合、jsonフォーマットで返す
    # end
  end
end
