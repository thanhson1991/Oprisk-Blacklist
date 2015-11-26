DELIMITER $$

USE `oprisk3`$$

DROP FUNCTION IF EXISTS `bia_calResultFunction`$$

CREATE DEFINER=`root`@`10.0.0.32` FUNCTION `bia_calResultFunction`(bia_profit1 DOUBLE, bia_profit2 DOUBLE, bia_profit3 DOUBLE, bia_alpha DOUBLE, bia_count INT) RETURNS DOUBLE
    DETERMINISTIC
BEGIN
IF bia_profit1 <= 0 THEN
	SET bia_profit1 = 0;
ELSE
	SET bia_count = bia_count + 1;
END IF;
IF bia_profit2 <= 0 THEN
	SET bia_profit2 = 0;
ELSE
	SET bia_count = bia_count + 1;
END IF;
IF bia_profit3 <= 0 THEN
	SET bia_profit3 = 0;
ELSE
	SET bia_count = bia_count + 1;
END IF;
IF bia_count > 0 THEN
	RETURN (bia_profit1+bia_profit2+bia_profit3)*bia_alpha / bia_count;
ELSE
	RETURN 0;
END IF;
     
END$$
    
DROP FUNCTION IF EXISTS `sa_calResultFunction`$$

CREATE DEFINER=`root`@`10.0.0.32` FUNCTION `sa_calResultFunction`(sa_businessProfit DOUBLE, sa_beta1 DOUBLE, sa_financialProfit DOUBLE, sa_beta2 DOUBLE, sa_retailProfit DOUBLE, sa_beta3 DOUBLE, sa_bankProfit DOUBLE, sa_beta4 DOUBLE, sa_paymentsProfit DOUBLE, sa_beta5 DOUBLE, sa_serviceProfit DOUBLE, sa_beta6 DOUBLE, sa_assetsProfit DOUBLE, sa_beta7 DOUBLE, sa_agencyProfit DOUBLE, sa_beta8 DOUBLE) RETURNS DOUBLE
    DETERMINISTIC
BEGIN
     RETURN (sa_businessProfit*sa_beta1)+(sa_financialProfit*sa_beta2)+(sa_retailProfit*sa_beta3)+(sa_bankProfit*sa_beta4)+(sa_paymentsProfit*sa_beta5)+(sa_serviceProfit*sa_beta6)+(sa_assetsProfit*sa_beta7)+(sa_agencyProfit*sa_beta8);
    END$$
    
DROP FUNCTION IF EXISTS `asa_calResultFunction`$$

CREATE DEFINER=`root`@`10.0.0.32` FUNCTION `asa_calResultFunction`(asa_businessProfit DOUBLE, asa_beta1 DOUBLE, asa_financialProfit DOUBLE, asa_beta2 DOUBLE, asa_loanPropfit DOUBLE,asa_m DOUBLE, sa_beta3 DOUBLE, asa_loanBankProfit DOUBLE, sa_beta4 DOUBLE, asa_paymentProfit DOUBLE, asa_beta5 DOUBLE, asa_serviceProfit DOUBLE, asa_beta6 DOUBLE, asa_assetsProfit DOUBLE, asa_beta7 DOUBLE, asa_retailProfit DOUBLE, asa_beta8 DOUBLE) RETURNS DOUBLE
    DETERMINISTIC
BEGIN
     RETURN (asa_businessProfit*asa_beta1)+(asa_financialProfit*asa_beta2)+(asa_loanPropfit*asa_m*sa_beta3)+(asa_loanBankProfit*asa_m*sa_beta4)+(asa_paymentProfit*asa_beta5)+(asa_serviceProfit*asa_beta6)+(asa_assetsProfit*asa_beta7)+(asa_retailProfit*asa_beta8);
    END$$
    
DROP FUNCTION IF EXISTS `bi_calResultFunction`$$

CREATE DEFINER=`root`@`10.0.0.32` FUNCTION `bi_calResultFunction`(profitIncome DOUBLE, profitCost DOUBLE, serviceIncome DOUBLE, serviceCost DOUBLE, anotherIncome DOUBLE,anotherCost DOUBLE, profitBusinessStock DOUBLE, profitBusinessInvest DOUBLE) RETURNS DOUBLE
    DETERMINISTIC
BEGIN
     RETURN ABS(profitIncome-profitCost)+serviceIncome+serviceCost+anotherIncome+anotherCost+ABS(profitBusinessStock)+ABS(profitBusinessInvest);
    END$$
    
DROP FUNCTION IF EXISTS `bi_TotalFunction`$$

CREATE DEFINER=`root`@`10.0.0.32` FUNCTION `bi_TotalFunction`(businessPoint DOUBLE, businessPointN4 DOUBLE, businessPointNN4 DOUBLE) RETURNS DOUBLE
    DETERMINISTIC
BEGIN
     RETURN (businessPoint+businessPointN4+businessPointNN4)*15/100/3;
    END$$
DELIMITER ;