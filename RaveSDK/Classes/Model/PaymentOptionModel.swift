//
//  PaymentOptionModel.swift
//  RaveSDK
//
//  Created by Rotimi Joshua on 08/02/2021.
//


import Foundation

public enum PaymentOption {
  case debitCard
  case bankAccount
  case bankTransfer
  case mobileMoney
  case ussd
  case voucherPayment
  case barter
}



public enum countryBanks: String {
  case nigeria
  case kenya
  case ghana
  case rwanda
  case zambia
  case cameroon
  case southAfrica
  case côtedIvoire
  case tanzania
  case uganda
}
