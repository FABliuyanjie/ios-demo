/*
 * Copyright (C) 2010 The MobileSecurePay Project
 * All right reserved.
 * author: shiqun.shi@alipay.com
 * 
 *  提示：如何获取安全校验码和合作身份者id
 *  1.用您的签约支付宝账号登录支付宝网站(www.alipay.com)
 *  2.点击“商家服务”(https://b.alipay.com/order/myorder.htm)
 *  3.点击“查询合作者身份(pid)”、“查询安全校验码(key)”
 */



//
// 请参考 Android平台安全支付服务(msp)应用开发接口(4.2 RSA算法签名)部分，并使用压缩包中的openssl RSA密钥生成工具，生成一套RSA公私钥。
// 这里签名时，只需要使用生成的RSA私钥。
// Note: 为安全起见，使用RSA私钥进行签名的操作过程，应该尽量放到商家服务器端去进行。
public final class Keys {

	//合作身份者id，以2088开头的16位纯数字
	public static final String DEFAULT_PARTNER = "2088211536968456";
//	public static final String DEFAULT_PARTNER = "2088801944194284";
	//收款支付宝账号
	public static final String DEFAULT_SELLER = "2088211536968456";
//	public static final String DEFAULT_SELLER="2088801944194284";

	//商户私钥，自助生成
	public static final String PRIVATE="MIICdQIBADANBgkqhkiG9w0BAQEFAASCAl8wggJbAgEAAoGBAKttoJCbTfDiQwV/BS1l9ww/8jaVBbwWyt4dONmbWiKGNitLFHCWQfm4Vi6LtloKu1kl74OEH2LXFUFRMvja8SMTai73wE/OY3Kz8j3UWWWNP/iIOWmeRxYucKWT7bvDKZE8eg72+YK4nv8Iduj81I+u8BTAE8Fzx+/v+XGx5wWdAgMBAAECgYAysXRtzr85oG8ZTPqG9kQcBzzlDyRm/oZ3MEUDdIEu/GlAXC9rK8POyMgTc5U1Az9rmWA+j++IFvpeGljsZjIwJMKUs07SwhZWwFA5aJOI7ls4QY8sBcZ2R8MeAFsheUIUgX56AkKCYLTRk/N+bR+AfqvTFNx8oNudDsDLUHsmsQJBAOVC+tiLXfNwHx26fLohRv0hJx4DSOIswrUlLfYFwOkXHuVYoj+6BV+EzyCZpY4lAR93664a+BjpkuT67LauDScCQQC/a+0wOhh3wlWqT0wbyrmQioUozjo+Nb+NCakiCfu+tTeXE/UiPPHrQ0PQwox/x6Eu+6aoMiYe5PFhdyyRCdmbAkAMH/C4Rxae600Z+2ThSyU/+eLhuXa/T3K0tdSqcD91lF1z764VBLeIB7QUm0ugKuDWUzdJq+93EdNM/OBMAQR9AkBfo6TWO7CN5WK3vPbhy9/6/7qYMLGY83HJHdKLV0GYfyJPMYGAocKdMPZpD0rzbOJzfvg9gRDazrhrYge6T5mRAkBZlp5tRRrHaLNzLjXQGn5wBUplmRLYAxpj64gSvUW0bEy3t5PubkSCSBGwSlrhWK3e5UXyC4sJu5qmWfEycTyk";
//	public static final String PRIVATE = "MIICXQIBAAKBgQDOYVRhckMhK19yfT46VKEGQicD7Z3Euc68/xJ2HHm+VNKGu6tVmCsB/GpMQ0cl1mA2mXG0pEgKr1KcegDLQIshJ4cdEI4WQ9x4wv42X2oWdBNgNHKF4QJ7qUwx3JHc/Mb7wrQhgfTNQUwelrm10X+Ce9DDGG2ualM0xX2zjUh6QQIDAQABAoGAdqtYjb/aAdSiyX5irb/D54laTdPwCBKfYeV5hBjTmDHF7Fs1Jb6d3EJ8DOYSnxspr7uDuk9MbXhqlDdDBZxTYu9Hq4mKCaz14R+xoS/fisyiTJz3RvUqYKQzQbmXzEK95HeSQnSz/vMurw+rCfA9kqt6pZLrYzo6Km+MxO33F8ECQQD/AngCSyr1RmMx4RU+/0wDp5SipNqWg694gXu0KNFckFeX+l1T+aJUu55USHdnMQxd0b+CtAfF51WwkFNG4tX9AkEAzy6DaCrSXmCC7ciIZvs54DRoT3Jk9qEa8tZbGB+HaQl1F715rWhMU2CURTMkTnv78E8PO0kqefCixb/ieJYGlQJAaIKvgmkiCvG0951CotXoZlsI3HtppmQDxwRyGUzdOO1jKMMP+rmFYOqfofUtElqUseKjdUKpKN99S+ZqatPOVQJBAJgAViSMlj7rq+NsprZ3RuT5TjZLhUt0s2LKZZbzOtOTPrcmKilRRf4980o51T9Hs3WBa3lhmqpQI/vVZgB2gWkCQQCtoNpP5Uv1z49AMIIxXvYq3GDLSfBLzApjAr4d6J0FxyH8XlsmHSz4KyVYpGBE76fQSUR5CZC+L0jNtGWQQ7eZ";			
	//	public static final String PRIVATE ="MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAMKEH5Vdut8hpatxx5FQOTUyzont140DkYVaEMqOlqJjNJNzpkAw9Zzvp0YGFSDKznMXKePtdmO9og8vd3SRyzJUufmh34/9ylFV/mecAoLzmMtMcY+jCatX04IjQanuFwkJ1iysr3wL/FHMYXnpb6CFdbgY7X31OvpRC2RExhEBAgMBAAECgYBEBLmanJUNE5IAGqBjkv7+OE768l2OpPHNBMqcWjIYhMJM0YMQLU6l2zPOC7B1sBVzL2Vpm47rn9M8pieKbrTzv3gj6Sc6dc7tUKJRpe1KKVenyptT5/y1N48cRSNK0HBGioIUOkVnPq/10jfQOEzT80hHT6krD4AszXgu/NHMAQJBAOf860iwZxDp1lKkqDmX+JT+1WarYmOETqCccps4Ft8GBzLHbwn0rwBVqBkPDu1oCOASxL5yA/9xHAytkX2yJ+ECQQDWpkwHq3MtRZugGkLWyzBWYbyWtMzuMOi3Nh/N7S3Pah3QZJRpZPWMtFGsSdhVat0uxeIeHxYWDuZqHNOr2I0hAkEA4CEt3BN58BBLXZrxYHtf0euGl2PbcdRA9tFPtIDzL9OuHrQppk+8x7D58APpYxrRAFOBu5GCJUfNVr5WQz9dYQJAIM+2241Hw+naCjU5dmAE+Y9jJp5onRh42li5r97Lm+Mav5pAXYQDTQjbWzzGhvgY62dwUy5pT+HjMuFJMgGeQQJAdaLdsDudYPS9SnKXd8yAXc7/2TmmjD8yVdlQBPXHBJ9U7AB26oj+9PHFNE8KcEJdqyUmfRxrF3p5AMVC7B0xeg==";
	public static final String PUBLIC = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCnxj/9qwVfgoUh/y2W89L6BkRAFljhNhgPdyPuBV64bfQNN1PjbCzkIM6qRdKBoLPXmKKMiFYnkd6rAoprih3/PrQEB/VsW8OoM8fxn67UDYuyBTqA23MML9q1+ilIZwBC2AQ2UBVOrFXfFl75p6/B5KsiNG9zpgmLCUYuLkxpLQIDAQAB";
//	public static final String PUBLIC = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCrbaCQm03w4kMFfwUtZfcMP/I2lQW8FsreHTjZm1oihjYrSxRwlkH5uFYui7ZaCrtZJe+DhB9i1xVBUTL42vEjE2ou98BPzmNys/I91FlljT/4iDlpnkcWLnClk+27wymRPHoO9vmCuJ7/CHbo/NSPrvAUwBPBc8fv7/lxsecFnQIDAQAB"	;
}
