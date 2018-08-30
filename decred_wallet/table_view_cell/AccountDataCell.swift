//  AccountDataCell.swift
//  Decred Wallet
//  Copyright © 2018 The Decred developers. All rights reserved.

import UIKit

class AccountDataCell: UITableViewCell, AccountDetailsCellProtocol {
    @IBOutlet private var containerStackView: UIStackView!
    
    // MARK: - Details
    
    @IBOutlet private var labelImmatureRewardValue: UILabel!
    @IBOutlet private var labelLockedByTicketsValue: UILabel!
    @IBOutlet private var labelVotingAuthorityValue: UILabel!
    @IBOutlet private var labelImmatureStakeGenerationValue: UILabel!
    
    // MARK: - Properties
    
    @IBOutlet private var labelAccountNoValue: UILabel!
    @IBOutlet private var labelHDPathValue: UILabel!
    @IBOutlet private var labelKeysValue: UILabel!
    
    @IBOutlet private var defaultWalletSwitch: UISwitch!
    
    private var accountDetails: AccountsEntity?
    
    var defaultWalletChanged: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        defaultWalletSwitch.addTarget(
            self,
            action: #selector(makeWalelltDefault),
            for: UIControlEvents.valueChanged
        )
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @objc private func makeWalelltDefault() {
        if defaultWalletSwitch.isOn {
            accountDetails?.makeDefault()
        } else {
            UserDefaults.standard.deleteDefaultAccountNumber()
        }
        defaultWalletChanged?()
    }
    
    func setup(account: AccountsEntity) {
        accountDetails = account
        
        labelImmatureRewardValue.text = "\(account.Balance?.dcrImmatureReward ?? 0)"
        labelLockedByTicketsValue.text = "\(account.Balance?.dcrLockedByTickets ?? 0)"
        labelVotingAuthorityValue.text = "\(account.Balance?.dcrVotingAuthority ?? 0)"
        labelImmatureStakeGenerationValue.text = "\(account.Balance?.dcrImmatureStakeGeneration ?? 0)"
        labelAccountNoValue.text = "\(account.Number)"
        // labelHDPathValue.text = "\(account.Balance)"
        defaultWalletSwitch.isOn = account.isDefaultWallet
        labelKeysValue.text = "\(account.ExternalKeyCount) External, \(account.InternalKeyCount) Internal, \(account.ImportedKeyCount) Imported"
    }
}
