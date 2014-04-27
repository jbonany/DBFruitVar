require 'test_helper'

class AccessionsControllerTest < ActionController::TestCase
  setup do
    @accession = accessions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:accessions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create accession" do
    assert_difference('Accession.count') do
      post :create, accession: { clon_name: @accession.clon_name, commercial_name: @accession.commercial_name, group_id: @accession.group_id, name: @accession.name, oldcode: @accession.oldcode, species_id: @accession.species_id, synonims: @accession.synonims }
    end

    assert_redirected_to accession_path(assigns(:accession))
  end

  test "should show accession" do
    get :show, id: @accession
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @accession
    assert_response :success
  end

  test "should update accession" do
    patch :update, id: @accession, accession: { clon_name: @accession.clon_name, commercial_name: @accession.commercial_name, group_id: @accession.group_id, name: @accession.name, oldcode: @accession.oldcode, species_id: @accession.species_id, synonims: @accession.synonims }
    assert_redirected_to accession_path(assigns(:accession))
  end

  test "should destroy accession" do
    assert_difference('Accession.count', -1) do
      delete :destroy, id: @accession
    end

    assert_redirected_to accessions_path
  end
end
