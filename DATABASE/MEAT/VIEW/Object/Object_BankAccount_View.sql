-- View: Object_BankAccount_View

CREATE OR REPLACE VIEW Object_BankAccount_View AS
         SELECT 
             Object_BankAccount.Id           AS Id
           , Object_BankAccount.ObjectCode   AS Code
           , Object_BankAccount.ValueData    AS Name
          
           , BankAccount_Juridical.ChildObjectId AS JuridicalId
           , Juridical.ValueData AS JuridicalName
           , ObjectLink_BankAccount_Bank.ChildObjectId   AS BankId  
           , Object_Bank_View.BankName                   AS BankName
           , Object_Bank_View.MFO                        AS MFO
           , BankAccount_Currency.ChildObjectId          AS CurrencyId
           , Currency.ValueData                          AS CurrencyName
           , Object_BankAccount.isErased                 AS isErased


       FROM Object AS Object_BankAccount
  LEFT JOIN ObjectLink AS ObjectLink_BankAccount_Bank
         ON ObjectLink_BankAccount_Bank.ObjectId = Object_BankAccount.Id
        AND ObjectLink_BankAccount_Bank.DescId = zc_ObjectLink_BankAccount_Bank()
  LEFT JOIN Object_Bank_View ON Object_Bank_View.Id = ObjectLink_BankAccount_Bank.ChildObjectId
  LEFT JOIN ObjectLink AS BankAccount_Juridical
         ON BankAccount_Juridical.ObjectId = Object_BankAccount.Id AND BankAccount_Juridical.DescId = zc_ObjectLink_BankAccount_Juridical()
  LEFT JOIN Object AS Juridical
       ON Juridical.Id = BankAccount_Juridical.ChildObjectId
  LEFT JOIN ObjectLink AS BankAccount_Currency
         ON BankAccount_Currency.ObjectId = Object_BankAccount.Id 
        AND BankAccount_Currency.DescId = zc_ObjectLink_BankAccount_Currency()
  LEFT JOIN Object AS Currency  ON Currency.Id = BankAccount_Currency.ChildObjectId
                               
     WHERE Object_BankAccount.DescId = zc_Object_BankAccount();


ALTER TABLE Object_BankAccount_View  OWNER TO postgres;


/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 15.11.13                         *
*/

-- ����
-- SELECT * FROM Object_BankAccount_View