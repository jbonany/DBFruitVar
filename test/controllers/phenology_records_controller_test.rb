require 'test_helper'

class PhenologyRecordsControllerTest < ActionController::TestCase
  setup do
    @phenology_record = phenology_records(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:phenology_records)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create phenology_record" do
    assert_difference('PhenologyRecord.count') do
      post :create, phenology_record: { block_id: @phenology_record.block_id, c3: @phenology_record.c3, e2: @phenology_record.e2, f2: @phenology_record.f2, g: @phenology_record.g, year: @phenology_record.year }
    end

    assert_redirected_to phenology_record_path(assigns(:phenology_record))
  end

  test "should show phenology_record" do
    get :show, id: @phenology_record
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @phenology_record
    assert_response :success
  end

  test "should update phenology_record" do
    patch :update, id: @phenology_record, phenology_record: { block_id: @phenology_record.block_id, c3: @phenology_record.c3, e2: @phenology_record.e2, f2: @phenology_record.f2, g: @phenology_record.g, year: @phenology_record.year }
    assert_redirected_to phenology_record_path(assigns(:phenology_record))
  end

  test "should destroy phenology_record" do
    assert_difference('PhenologyRecord.count', -1) do
      delete :destroy, id: @phenology_record
    end

    assert_redirected_to phenology_records_path
  end
end
