

Sets       j     companies /1*1/
           t     Time     /1*1/
           scenario /high,low,volatility/
           s(scenario)
           ;
parameters
            a            Intercept of the CDF of the uniform dist/1/
            b            slope of the CDF of the uniform dist/1/
            r_max        Highest possible ranking/5/
            r_min        Lowest possible ranking/1/
            l0           percentage of local content/0/
            l_min,l_max,l_avg,l_std,l_alpha,l_beta

            E0           the target price of electricity ($ per Mwh) /16/
            E_bar        The maximum price of electricity USD per MWh /100/
            E_min,E_max,E_avg,E_std,E_alpha,E_beta

            delta0       the target capacity price ($ per KW)       /145/
            delta_bar    The maximum price of capacity USD per KW /150/
            delta_min,delta_max,delta_avg,delta_std,delta_alpha,delta_beta
            g           slope on the capacity equation

            K0           the installed capacity  GW /3.93/

            theta0        /0.7 /
            theta_bar     /0.6 /
            theta_min,theta_max,theta_avg,theta_std,theta_alpha,theta_beta

            y0           minimum years of experience /0/
            y_bar        the targeted number of years of experience/10/
            y_min,y_max,y_avg,y_std,y_alpha,y_beta

            h0           minimum financial strength factor /0/
            h_min,h_max,h_avg,h_std,h_alpha,h_beta

            mu  factor for the increase of project costs due to higher financial strength

            tau_c        the impact of the number of years of lack of experience on cost slippage
            tau_f        the impact of the number of years of lack of experience on cost slippage

            eps_l        /0.1/
            eps_h        /0.1/

            i            discount rate   /0.05 /

            ci           International marginal cost $ per Mwh /15/
            cl           100% local content marginal cost $ per Mwh /15/
            c0
            fi           annualized capital cost of equipment USD per KW (CCGT)/188/
            fl           domestic capital cost of equipment USD per KW (CCGT) /188/
            f0           reported captial cost
            Shadow_E(t)
            Shadow_delta
            Shadow_l
            Shadow_h
            Shadow_y
            Shadow_Sum
            Shadow_theta
            CS consumer surplus
            Pi
            cost_ppa
            cost_gen
            fixed_cost
            marginal_cost
;
