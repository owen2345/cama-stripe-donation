// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(function() {
  $('form.plugin_stripe_donation_form').each(function() {
    const form = $(this);
    const handler_stripe = () => StripeCheckout.configure({
      key: form.attr('data-key'),
      locale: 'auto',
      token(token){
        for (const [k, v] in token) {
          form.append('<input type="hidden" name="stripe['+k+']" value="'+ v +'">');
        }
        form.submit();
      }
    });

    form.find('button').click(function() {
      handler_stripe.open({
        name: form.attr('data-name'),
        currency: form.attr('data-currency'),
        description: form.attr('data-descr'),
        amount: form.attr('data-amount')
      });
      return false;
    });
  });

  // Close Checkout on page navigation
  $(window).on('popstate', () => handler_stripe.close());
});
