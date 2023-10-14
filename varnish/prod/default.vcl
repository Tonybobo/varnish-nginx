vcl 4.0;
backend default {
    .host = "localhost";
    .port = "8080";
}
sub vcl_recv {
}
sub vcl_backend_response {
}
sub vcl_deliver {
}