--UEF ACU

local oldUEL0001 = UEL0001
UEL0001 = Class(oldUEL0001) {

	-- ********
    -- Creation
    -- ********
	local oldOnCreate = OnCreate
    OnCreate = function(self)
        oldOnCreate(self)
        self:SetCapturable(false)
        self:HideBone('Back_Upgrade', true)
        self:HideBone('Right_Upgrade', true)
        if self:GetBlueprint().General.BuildBones then
            self:SetupBuildBones()
        end
        -- Restrict what enhancements will enable later
        --self:AddBuildRestriction( categories.UEF * (categories.BUILTBYTIER2COMMANDER + categories.BUILTBYTIER3COMMANDER) )
		self:AddBuildRestriction( categories.CYBRAN * (categories.FACTORY + categories.TECH1 + categories.LAND + categories.STRUCTURE ))
    end,
	
	local oldCreateEnhancement = CreateEnhancement()
    CreateEnhancement = function(self, enh)
        oldCreateEnhancement(self, enh)
        --Cybran Engineering
        if enh =='CybranEngineering' then
            local bp = self:GetBlueprint().Enhancements[enh]
            if not bp then return end
            local cat = ParseEntityCategory(bp.BuildableCategoryAdds)
            self:RemoveBuildRestriction(cat)
			-- Engymod addition: After fiddling with build restrictions, update engymod build restrictions
			self:updateBuildRestrictions()
		elseif enh =='CybranEngineeringRemove' then
            local bp = self:GetBlueprint().Economy.BuildRate
            if not bp then return end
            self:RestoreBuildRestrictions()
            self:AddBuildRestriction( categories.CYBRAN * (categories.FACTORY + categories.TECH1 + categories.LAND + categories.STRUCTURE ))
            self:AddBuildRestriction( categories.CYBRAN * (categories.FACTORY + categories.TECH1 + categories.LAND + categories.STRUCTURE ))
            -- Engymod addition: After fiddling with build restrictions, update engymod build restrictions
            self:updateBuildRestrictions()
        else
    end,

}


