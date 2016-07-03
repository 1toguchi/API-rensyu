class BooksController < ApplicationController
  def new
    if params[:books][:keyword].present?
      #　デバックログ出力するために記述
      Amazon::Ecs.debug = true

      # Amazon::Ecs::Responceオブジェクトの取得
      books = Amazon::Ecs.item_search(
        params[:books][:keyword],
        search_index:  'Books',
        dataType: 'script',
        response_group: 'ItemAttributes, Images',
        country:  'jp',
        power: "Not kindle"
      )

      # 本のタイトル,画像URL, 詳細ページURLの取得
      @books = []
      books.items.each do |item|
        book = Book.new(
          title:  item.get('ItemAttributes/Title'),
          image:  item.get('LargeImage/URL'),
          detail: item.get('DetailPageURL'),
        )
        @books << book
      end
    end
  end

  def form
  end

  def index
  end
end
