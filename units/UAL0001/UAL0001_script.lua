local oldUAL0001 = UAL0001
UAL0001 = Class(oldUAL0001) {


    OnCreate = function(self)
        ACUUnit.OnCreate(self)
        self:SetCapturable(false)
        self:SetWeaponEnabledByLabel('ChronoDampener', false)
        self:SetupBuildBones()
        self:HideBone('Back_Upgrade', true)
        self:HideBone('Right_Upgrade', true)        
        self:HideBone('Left_Upgrade', true)            
        -- Restrict what enhancements will enable later
        self:AddBuildRestriction( categories.AEON * (categories.BUILTBYTIER2COMMANDER + categories.BUILTBYTIER3COMMANDER) )
    end,

}

