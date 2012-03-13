require File.join(File.dirname(__FILE__),'..','spec_helper')

describe "Product" do
 it_should_behave_like "SpecHelper" do
   
  before(:each) do
    setup_test_for Product,'testuser'
    @product = {
      'upc' => '1571501',
      'name' => 'New',
      'model' => 'Test',
      'quantity' => '10'
    }
  end

  it "should process Product query" do
    test_create(@product)
    test_query.size.should > 0
    query_errors.should == {}
  end

  it "should process Product create" do
    new_product_id = test_create(@product)
    new_product_id.should_not be_nil
    create_errors.should == {}
    md[new_product_id].should == @product
  end

  it "should process Product update" do
    product_id = test_create(@product)
    md.should == {product_id => @product}
    test_update({product_id => {'model' => 'Test'}})
    update_errors.should == {}
    test_query
    md[product_id]['model'].should == 'Test'
  end

  it "should process Product delete" do
    product_id = test_create(@product)
    md.should == {product_id => @product}
    test_delete(product_id => @product)
    delete_errors.should == {}
    md.should == {}
  end

  end  
end