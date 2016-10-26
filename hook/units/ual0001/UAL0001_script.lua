--AEON ACU

local oldUAL0001 = UAL0001
UAL0001 = Class(oldUAL0001) {

	OnCreate = function(self)
		oldUAL0001.OnCreate(self)
		--ACUUnit.OnCreate(self)
		self:AddBuildRestriction(categories.CYBRAN)
		self:AddBuildRestriction(categories.SERAPHIM)
		self:AddBuildRestriction(categories.UEF)
	end,
	
	CreateBuildEffects = function( self, unitBeingBuilt, order )
        local UpgradesFrom = unitBeingBuilt:GetBlueprint().General.UpgradesFrom
		local faction =  unitBeingBuilt:GetBlueprint().General.FactionName
		
		
		-- cybran
		if faction == 'Cybran' then
			EffectUtil.SpawnBuildBots( self, unitBeingBuilt, self.BuildEffectsBag )
			EffectUtil.CreateCybranBuildBeams( self, unitBeingBuilt, self:GetBlueprint().General.BuildBones.BuildEffectBones, self.BuildEffectsBag )
		elseif faction == 'UEF' then
			--If we are assisting an upgrading unit, or repairing a unit, play separate effects
			if (order == 'Repair' and not unitBeingBuilt:IsBeingBuilt()) or (UpgradesFrom and UpgradesFrom ~= 'none' and self:IsUnitState('Guarding'))then
				EffectUtil.CreateDefaultBuildBeams( self, unitBeingBuilt, self:GetBlueprint().General.BuildBones.BuildEffectBones, self.BuildEffectsBag )
			else
				EffectUtil.CreateUEFCommanderBuildSliceBeams( self, unitBeingBuilt, self:GetBlueprint().General.BuildBones.BuildEffectBones, self.BuildEffectsBag )        
			end
		elseif faction == 'Seraphim' then
			EffectUtil.CreateSeraphimUnitEngineerBuildingEffects( self, unitBeingBuilt, self:GetBlueprint().General.BuildBones.BuildEffectBones, self.BuildEffectsBag )
		else
			EffectUtil.CreateAeonCommanderBuildingEffects( self, unitBeingBuilt, self:GetBlueprint().General.BuildBones.BuildEffectBones, self.BuildEffectsBag )
		end
        
    end,
	
    CreateEnhancement = function(self, enh)
        oldUAL0001.CreateEnhancement(self, enh)
		
		local bp = self:GetBlueprint().Enhancements[enh]
        if not bp then return end
		
        if enh =='CybranEngineering' then
            local cat = ParseEntityCategory(bp.BuildableCategoryAdds)
            self:RemoveBuildRestriction(cat)
            -- Engymod addition: After fiddling with build restrictions, update engymod build restrictions
            self:updateBuildRestrictions()
        elseif enh =='CybranEngineeringRemove' then
            local bp = self:GetBlueprint().Economy.BuildRate
            if not bp then return end
            self:AddBuildRestriction(categories.CYBRAN)
            -- Engymod addition: After fiddling with build restrictions, update engymod build restrictions
            self:updateBuildRestrictions()
		elseif enh =='SeraEngineering' then
            local cat = ParseEntityCategory(bp.BuildableCategoryAdds)
            self:RemoveBuildRestriction(cat)
            -- Engymod addition: After fiddling with build restrictions, update engymod build restrictions
            self:updateBuildRestrictions()
        elseif enh =='SeraEngineeringRemove' then
            local bp = self:GetBlueprint().Economy.BuildRate
            if not bp then return end
			self:AddBuildRestriction(categories.SERAPHIM)
            -- Engymod addition: After fiddling with build restrictions, update engymod build restrictions
            self:updateBuildRestrictions()
		elseif enh =='UEFEngineering' then
            local cat = ParseEntityCategory(bp.BuildableCategoryAdds)
            self:RemoveBuildRestriction(cat)
            -- Engymod addition: After fiddling with build restrictions, update engymod build restrictions
            self:updateBuildRestrictions()
        elseif enh =='UEFEngineeringRemove' then
            local bp = self:GetBlueprint().Economy.BuildRate
            if not bp then return end
			self:AddBuildRestriction(categories.UEF)
            -- Engymod addition: After fiddling with build restrictions, update engymod build restrictions
            self:updateBuildRestrictions()
			-- ***
			--
       elseif enh =='AdvancedEngineeringRemove' then
            local bp = self:GetBlueprint().Economy.BuildRate
            if not bp then return end
            self:RestoreBuildRestrictions()
            self:AddBuildRestriction( categories.AEON * (categories.BUILTBYTIER2COMMANDER + categories.BUILTBYTIER3COMMANDER) )
            if Buff.HasBuff( self, 'AeonACUT2BuildRate' ) then
                Buff.RemoveBuff( self, 'AeonACUT2BuildRate' )
			end
			--
			self:AddBuildRestriction(categories.CYBRAN)
			self:AddBuildRestriction(categories.SERAPHIM)
			self:AddBuildRestriction(categories.UEF)
			--
            self:updateBuildRestrictions()
        elseif enh =='T3EngineeringRemove' then
            local bp = self:GetBlueprint().Economy.BuildRate
            if not bp then return end
            self:RestoreBuildRestrictions()
            self:AddBuildRestriction( categories.AEON * ( categories.BUILTBYTIER2COMMANDER + categories.BUILTBYTIER3COMMANDER) )
            if Buff.HasBuff( self, 'AeonACUT3BuildRate' ) then
                Buff.RemoveBuff( self, 'AeonACUT3BuildRate' )
			end
			--
			self:AddBuildRestriction(categories.CYBRAN)
			self:AddBuildRestriction(categories.SERAPHIM)
			self:AddBuildRestriction(categories.UEF)
			--
            -- Engymod addition: After fiddling with build restrictions, update engymod build restrictions
            self:updateBuildRestrictions()
		end
		
    end,
}

TypeClass = UAL0001
