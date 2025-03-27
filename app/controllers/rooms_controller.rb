class RoomsController < ApplicationController
    before_action :authenticate_user!  # ログインしていることを確認

    def own
        @rooms = current_user.rooms
    end

    def index
        @rooms = Room.all

        # エリア検索 -> addressカラムに対する部分一致検索
        if params[:area].present?
            @rooms = @rooms.where("address LIKE ?", "%#{params[:area]}%")
            @room_count = @rooms.count  # エリア検索結果の件数をカウント
        end
  
        # 住所のあいまい検索
        if params[:address].present?
            @rooms = @rooms.search_by_address(params[:address])
            @room_count = @rooms.count  # 住所検索結果の件数をカウント
        end
  
        # 施設名（name）のあいまい検索
        if params[:name].present?
            @rooms = @rooms.search_by_name(params[:name])
            @room_count = @rooms.count  # 施設名検索結果の件数をカウント
        end
  
        # 施設詳細（description）のあいまい検索
        if params[:description].present?
            @rooms = @rooms.search_by_description(params[:description])
            @room_count = @rooms.count  # 施設詳細検索結果の件数をカウント
        end
    end

    def new
        @room = Room.new
    end

    def create
        @room = current_user.rooms.build(room_params)

        if @room.save
            flash[:notice] = "新規施設登録が完了しました"
            redirect_to own_room_rooms_path
        else
            flash[:alert] = "新規施設登録に失敗しました"
            render :new
        end
    end

    def show
        @room =Room.find(params[:id])
        @reservation = Reservation.new
    end

    def edit
        @room =Room.find(params[:id])
    end

    def update
        @room =Room.find(params[:id])
        if @room.update(room_params)
            flash[:notice] = "施設情報が更新されました"
            redirect_to own_room_rooms_path
        else
            flash[:alert] = "施設情報の更新に失敗しました"
            render :edit
        end
    end

    def destroy
        @room =Room.find(params[:id])
        @room.destroy
        flash[:notice] = "登録されていた施設を削除しました"
        redirect_to own_room_rooms_path
    end

    def room_params
        params.require(:room).permit(:name, :description, :price, :address, :image)
    end
end
