
function [ H2to1 ] = computeH(x1, x2)

x1 = transpose(x1);
x2 = transpose(x2);

n = size(x1, 2);

Mat = [-[ x2(1,:); x2(2,:); ones(1, n); -zeros(3, n);
      -times(x1(1,:), x2(1,:)); 
      -times(x1(1,:), x2(2,:));
      -x1(1,:)] [zeros(3, n); x2(1,:); x2(2,:); ones(1, n); 
      -times(x1(2,:), x2(1,:));
      -times(x1(2,:), x2(2,:)); -x1(2,:) ]
      ];
  
if n <= 4
    [U, S, V] = svd(Mat);
else
    [U, S, V] = svd(Mat, 'econ');
end

U = U(:,9);
U = reshape(U, 3, 3);

H2to1 = U';
end
