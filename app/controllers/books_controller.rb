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
    else
      params[:keyword] 
      #このparams[:keyword]は当然nilかblankになる。
      #なぜならl.27のelseはif params[:keyword].present?がfalseの状態だから
    end
  end

  def form
  end

  def home
  end

  def create
    @books= Book.new(book_params)
    if @books.save #saveするかどうかの判定はvalidationとかによる。なのでmodels/Book.rbにvalidationを追加したほうがいいかもね
      #redirect_to :path, notice: '保存しました。'みたいな奴がないからここで止まってしまう。
    else
      render "new"
    end
  end

  private
  def book_params
    params.require(:books).permit(:title, :detail, :image)
    #requireの引数はbooks複数形ではなく単数形だと思われる。
  end #endのインデントはきちんとそろえること(こういう細かいところレビューの時に結構見られるから注意)
end
