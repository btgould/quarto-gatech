-- Container-title substring -> abbreviation, used by per-slide-refs.lua for
-- the per-slide citation asides. Matched via plain substring on the
-- stringified Emph content; first match wins. Full journal/conference names
-- are kept in the end-of-deck bibliography, which Quarto's own citeproc pass
-- renders untouched.
--
-- Add entries here to abbreviate further venues in the asides.

return {
	{ "Conference on Decision and Control", "CDC" },
	{ "International Conference on Robotics and Automation", "ICRA" },
	{ "American Control Conference", "ACC" },
	{ "European Control Conference", "ECC" },
	{ "Advances in Neural Information Processing Systems", "NeurIPS" },
	{ "Conference on Neural Information Processing Systems", "NeurIPS" },
	{ "International Conference on Machine Learning", "ICML" },
	{ "International Conference on Learning Representations", "ICLR" },
	{ "Conference on Robot Learning", "CoRL" },
	{ "Journal of Machine Learning Research", "JMLR" },
	{ "International Conference on Cyber-Physical Systems", "ICCPS" },
	{ "IFAC Conference on Analysis and Design of Hybrid Systems", "ADHS" },
	{ "Transactions on Automatic Control", "IEEE TAC" },
	{ "Transactions on Embedded Computing Systems", "TECS" },
	{ "International Journal of Robotics Research", "IJRR" },
	{ "Control Systems Letters", "IEEE L-CSS" },
	{ "Mathematics of Control, Signals, and Systems", "MCSS" },
	{ "Annual Review of Control, Robotics, and Autonomous Systems", "Annu. Rev. Control Robot. Auton. Syst." },
	{ "arXiv", "arXiv" },
}
