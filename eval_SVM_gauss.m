function [qg_test]=eval_SVM_gauss(z_test,z,qg_max,N,testwin,gamma,a,b)
delta=1;
T=testwin;
for i=1:N
    z_n_test=[z_test(i,:);z_test(i+N,:);z_test(i+2*N,:)];
    z_n_test(isnan(z_n_test))=0;
%     z_n_test=[z_n_test;z_test(3*N+1:3*N+1,:)];
    
    z_n_train=[z(i,:);z(i+N,:);z(i+2*N,:)];
    z_n_train(isnan(z_n_train))=0;
%     z_n_train=[z_n_train;z(3*N+1:3*N+1,:)];

%     reg=delta*(eye(size(z_n_test,2)));

     A_test=diag(exp((-diag(z_n_test'*z_n_test)/gamma)));
    B_test=exp(2*(z_n_test'*z_n_train)/gamma);
    C_test=diag(exp((-diag(z_n_train'*z_n_train)/gamma)));
    K_test(:,:,i)=A_test*B_test*C_test;
    qg_test(:,i)=K_test(:,:,i)*a(:,i)+b(i)*ones(T,1);
    qg_test(:,i)=min(abs(qg_test(:,i)),qg_max(i,:)').*sign(qg_test(:,i));
%     qg_test(isnan(qg_test))=0;
end
qg_test=value(qg_test');
end