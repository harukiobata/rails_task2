class ReservationsController < ApplicationController
    before_action :authenticate_user!
    def index
        @reservations = Reservation.where(user_id: current_user.id).includes(:room)

        @reservations.each do |reservation|
            reservation.stay_duration = (reservation.check_out_date - reservation.check_in_date).to_i
            reservation.total_price = reservation.stay_duration * reservation.room.price
        end
    end

    def preview
        @reservation = Reservation.new(reservation_params)
        @reservation.user_id = current_user.id
        @room = Room.find(@reservation.room_id)
        if @reservation.invalid?
            flash[:alert] = @reservation.errors.full_messages.join(", ")
            render 'rooms/show' and return
        end
        @stay_duration = (@reservation.check_out_date - @reservation.check_in_date).to_i    
        @price_per_night = @room.price  
        @total_price = @stay_duration * @price_per_night * @reservation.number_of_people
    end

    def create
        @reservation = Reservation.new(reservation_params)
        @reservation.user_id = current_user.id  # ログインユーザーのIDを予約に設定
        if @reservation.save
          redirect_to reservations_path, notice: "予約が完了しました！"
        else
          render :preview
        end
    end

    def edit
        @reservation = Reservation.find(params[:id])
    end

    def update
        @reservation = Reservation.find(params[:id])
        if @reservation.update(reservation_params)
          redirect_to reservations_path, notice: "予約が更新されました！"
        else
          render :edit
        end
    end

    def destroy
        @reservation = Reservation.find(params[:id])
        @reservation.destroy
        redirect_to reservations_path, notice: "予約が削除されました。"
    end

    private

    def reservation_params
        params.require(:reservation).permit(:check_in_date, :check_out_date, :number_of_people, :room_id)
    end
end
