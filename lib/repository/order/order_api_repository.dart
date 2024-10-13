abstract class OrderApiRepository {
  // Todo Add To Cart Api

  Future<void> addToCart(dynamic body);

  // Todo Sending Empty API To Hit Order & ALL The Logic Cover in the backend
  Future<void> placeOrdersApi();

  // Todo Clear Cart From Backend

  Future<void> clearCart(dynamic body);

  // Todo Checkout Order Cash On Deleivery
  Future<void> checkOutOrder(dynamic body);

  // Todo Checkout Order Stripe Payment
  Future<void> checkOutStripeOrder(dynamic body);
}
