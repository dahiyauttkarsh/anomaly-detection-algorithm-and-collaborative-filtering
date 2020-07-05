function [J, grad] = cofiCostFunc(params, Y, R, num_users, num_movies, ...
                                  num_features, lambda)
%COFICOSTFUNC Collaborative filtering cost function
%   [J, grad] = COFICOSTFUNC(params, Y, R, num_users, num_movies, ...
%   num_features, lambda) returns the cost and gradient for the
%   collaborative filtering problem.
%

% Unfold the U and W matrices from params
X = reshape(params(1:num_movies*num_features), num_movies, num_features);
Theta = reshape(params(num_movies*num_features+1:end), ...
                num_users, num_features);

            
% You need to return the following values correctly
J = 0;
X_grad = zeros(size(X));
Theta_grad = zeros(size(Theta));

s = X*transpose(Theta);
temp1 = s - Y;
temp2 = (temp1.^2)/2;
temp3 = R.*temp2;
J = sum(sum(temp3));


         
            
temp4 = R.*temp1;

X_grad = temp4*Theta;

Theta_grad = transpose(temp4)*X;

reg = sum(sum(Theta.^2))*lambda/2 + sum(sum(X.^2))*lambda/2;
J = J +reg;

reg_xg = X*lambda;
reg_tg = Theta*lambda;
X_grad = X_grad + reg_xg;
Theta_grad = Theta_grad + reg_tg;




grad = [X_grad(:); Theta_grad(:)];

end
