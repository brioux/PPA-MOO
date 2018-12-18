# PPA-MOO

Run model using the PPA_model.gms file


This model is used to simualte the optimal weights applied to the criteria (energy price, capacity price, years of experience, locla content and financial strenght) used by a buyer to select bids for a Purchase Power Agreement submitted by generation companies.


It is constructed as a bi-level problem, where the leader maximizes the weighted gains received by the buyer of the PPA under the winning bid when compared to the target, by optmizing the weight applied to each criteria. The inner level problem of the generator is to maximize the expected profit of winning the bid, subject to a bid resonse function (likelihood of winning the bid). The generator optimizes the weighted criteria for the PPA.

The model is generated using the Extended Mathmatical Programming framework.