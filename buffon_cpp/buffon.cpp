#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
List cast_needle(
  unsigned int plane_width = 20
){
  // Variable declaration
  int available_range;
  double angle,my_pi;
  NumericVector x_start(2), x_end(2), tmp_angle(1);
  bool cross;
  
  // Computation
  my_pi = atan(1) * 4; // defines pi (for simplicity)
  available_range = plane_width / 2 - 1;
  x_start = runif(2, -available_range, available_range);
  tmp_angle = runif(1, 0, 2 * my_pi);
  angle = tmp_angle[0];
  x_end[0] = cos(angle) + x_start[0];
  x_end[1] = sin(angle) + x_start[1];
  cross = floor(x_start[2]) != floor(x_end[2]);
  
  return List::create(
    Named("start") = x_start,
    Named("end") = x_end,
    Named("cross") = cross
  );
}

// [[Rcpp::export]]
List buffon_experiment(
  int B = 2084,
  int plane_width = 10
){
  // Variable declaration
  NumericMatrix X_start(B,2), X_end(B,2);
  LogicalVector cross(B);
  List L;
  NumericVector tmp(2);
  
  // Computation
  for(int i(0); i<B; ++i){
    L = cast_needle(plane_width);
    tmp = L["start"];
    X_start(i,_) = tmp; 
    tmp = L["end"];
    X_end(i,_) = tmp;
    cross(i) = L["cross"];
  }
  
  return List::create(
    Named("start") = X_start,
    Named("end") = X_end,
    Named("cross") = cross,
    Named("plane") = plane_width
  );
}


