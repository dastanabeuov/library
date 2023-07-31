class BooksController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :preview_book]
  load_and_authorize_resource except: [:index, :preview_book]

  before_action :set_book, only: %i[ show edit update destroy preview_book]

  def preview_book
  end

  # GET /books or /books.json
  def index
    @categories = Category.all

    @q = Book.ransack(params[:q])
    @books  = @q.result(distinct: true)

    @pagy, @books = pagy(@books)
  end

  # GET /books/1 or /books/1.json
  def show
    @pdf_url = url_for(@book.main_pdf) if @book.main_pdf.attached?
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books or /books.json
  def create
    @book = Book.new(book_params)
    #@book.user_id = current_user.id

    respond_to do |format|
      if @book.save
        format.html { redirect_to book_url(@book), notice: "Книга успешно создана." }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1 or /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to book_url(@book), notice: "Книга успешно обновлена." }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1 or /books/1.json
  def destroy
    @book.destroy

    respond_to do |format|
      format.html { redirect_to books_url, notice: "Книга успешно удалена." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def book_params
      params.require(:book).permit(:user_id, :title, :author, :description, :main_pdf, category_ids: [])
    end
end
