require 'test_helper'

class ProductionRecordsControllerTest < ActionController::TestCase
  setup do
    @production_record = production_records(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:production_records)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create production_record" do
    assert_difference('ProductionRecord.count') do
      post :create, production_record: { block_id: @production_record.block_id, c5560: @production_record.c5560, c55: @production_record.c55, c6065: @production_record.c6065, c6568: @production_record.c6568, c65: @production_record.c65, c6870: @production_record.c6870, c7072: @production_record.c7072, c7275: @production_record.c7275, c7580: @production_record.c7580, c8085: @production_record.c8085, c80: @production_record.c80, c8590: @production_record.c8590, c90: @production_record.c90, harvest_date: @production_record.harvest_date, production: @production_record.production, tree_number: @production_record.tree_number }
    end

    assert_redirected_to production_record_path(assigns(:production_record))
  end

  test "should show production_record" do
    get :show, id: @production_record
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @production_record
    assert_response :success
  end

  test "should update production_record" do
    patch :update, id: @production_record, production_record: { block_id: @production_record.block_id, c5560: @production_record.c5560, c55: @production_record.c55, c6065: @production_record.c6065, c6568: @production_record.c6568, c65: @production_record.c65, c6870: @production_record.c6870, c7072: @production_record.c7072, c7275: @production_record.c7275, c7580: @production_record.c7580, c8085: @production_record.c8085, c80: @production_record.c80, c8590: @production_record.c8590, c90: @production_record.c90, harvest_date: @production_record.harvest_date, production: @production_record.production, tree_number: @production_record.tree_number }
    assert_redirected_to production_record_path(assigns(:production_record))
  end

  test "should destroy production_record" do
    assert_difference('ProductionRecord.count', -1) do
      delete :destroy, id: @production_record
    end

    assert_redirected_to production_records_path
  end
end
